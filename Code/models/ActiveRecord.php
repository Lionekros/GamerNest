<?php

namespace Model;

class ActiveRecord
{
    // Database
    protected static $db;
    protected static $table = '';
    protected static $columsDB = [];

    // Alerts and Messages
    protected static $alerts = [];

    // Set the connection to the database - includes/database.php
    public static function setDB($database)
    {
        self::$db = $database;
    }

    public static function setAlert($type, $message)
    {
        static::$alerts[$type][] = $message;
    }

    // Validation
    public static function getAlerts()
    {
        return static::$alerts;
    }

    public function validate()
    {
        static::$alerts = [];
        return static::$alerts;
    }

    // SQL query to create an object in memory
    public static function consultSQL($query)
    {
        // Query the database
        $result = self::$db->query($query);

        // Iterate through the results
        $array = [];
        while ($record = $result->fetch_assoc()) {
            $array[] = static::createObject($record);
        }

        // Free memory
        $result->free();

        // Return the results
        return $array;
    }

    // Creates the object in memory that is equal to the one in the database
    protected static function createObject($record)
    {
        $object = new static;

        foreach ($record as $key => $value) {
            if (property_exists($object, $key)) {
                $object->$key = $value;
            }
        }

        return $object;
    }

    // Identify and join the attributes of the database
    public function attributes()
    {
        $attributes = [];
        foreach (static::$columsDB as $column) {
            if ($column === 'id')
                continue;
            $attributes[$column] = $this->$column;
        }
        return $attributes;
    }

    // Sanitize data before saving to the database
    public function sanitizeAttribute()
    {
        $attributes = $this->attributes();
        $sanitized = [];
        foreach ($attributes as $key => $value) {
            $sanitized[$key] = self::$db->escape_string($value);
        }
        return $sanitized;
    }

    // Synchronize database with objects in memory
    public function sync($args = [])
    {
        foreach ($args as $key => $value) {
            if (property_exists($this, $key) && !is_null($value)) {
                $this->$key = $value;
            }
        }
    }

    // Records - CRUD
    public function save()
    {
        $result = '';
        if (!is_null($this->id)) {
            // update
            $result = $this->update();
        } else {
            // Creating a new record
            $result = $this->create();
        }
        return $result;
    }

    // Find a record by its id
    public static function find($id)
    {
        $query = "SELECT * FROM " . static::$table . " WHERE id = ${id}";
        $result = self::consultSQL($query);
        return array_shift($result);
    }

    // Get records with certain amount
    public static function get($limit)
    {
        $query = "SELECT * FROM " . static::$table . " LIMIT ${$limit}";
        $result = self::consultSQL($query);
        return array_shift($result);
    }

    // create a new record
    public function create()
    {
        // Sanitize data
        $attribute = $this->sanitizeAttribute();

        // Insert into the database
        $query = " INSERT INTO " . static::$table . " ( ";
        $query .= join(', ', array_keys($attribute));
        $query .= " ) VALUES (' ";
        $query .= join("', '", array_values($attribute));
        $query .= " ') ";

        // Query result
        $result = self::$db->query($query);
        return [
            'resultado' => $result,
            'id' => self::$db->insert_id
        ];
    }

    // Update record
    public function update()
    {
        // Sanitize data
        $attribute = $this->sanitizeAttribute();

        // Iterate to add each field in the database
        $values = [];
        foreach ($attribute as $key => $value) {
            $values[] = "{$key}='{$value}'";
        }

        // SQL query
        $query = "UPDATE " . static::$table . " SET ";
        $query .= join(', ', $values);
        $query .= " WHERE id = '" . self::$db->escape_string($this->id) . "' ";
        $query .= " LIMIT 1 ";

        // Update database
        $result = self::$db->query($query);
        return $result;
    }

    // Delete a Record by its ID
    public function delete()
    {
        $query = "DELETE FROM " . static::$table . " WHERE id = " . self::$db->escape_string($this->id) . " LIMIT 1";
        $result = self::$db->query($query);
        return $result;
    }
}
