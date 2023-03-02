{{-- <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <span class="navbar-brand mb-0 h1">Blog</span>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav"
        aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="{{ route('inicio') }}">Inicio</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="{{ route('posts.index') }}">Listado de post</a>
            </li>
            @if (auth()->check())
                <li class="nav-item">
                    <a class="nav-link" href="{{ route('logout') }}">Logout</a>
                </li>
            @else
                <li class="nav-item">
                    <a class="nav-link" href="{{ route('login') }}">Login</a>
                </li>
            @endif
        </ul>
    </div>
    <div class="d-flex justify-content-end">
        <h5 class="text-white my-2 my-sm-0">{{ currentDate('d/m/y') }}</h5>
    </div>
</nav> --}}
