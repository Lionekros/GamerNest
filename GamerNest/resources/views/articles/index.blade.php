@extends('template')

@section('title', 'Listado posts')

@section('content')
@forelse ($articles as $article)
{{$article->id}}
@empty

@endforelse
@endsection