<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <title>Dias desde que Midzu</title>
    <style>
        body {
            width: 100dvw;
            height: 100dvh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #ad8dda;
            color: #fff;
            margin: 0;
            font-family: system-ui, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Oxygen, Ubuntu, Cantarell, Open Sans, Helvetica Neue, sans-serif
        }

        h1 {
            font-size: 3rem;
            margin-bottom: 6rem
        }

        .elements {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            grid-template-rows: auto 1fr;
            gap: 2rem
        }

        .title {
            font-size: larger;
            text-align: center;
            grid-row: 2 / 3;
            margin: auto 0;
            padding-left: 1rem;
            padding-right: 1rem
        }

        .element {
            font-size: 4rem;
            font-weight: 600;
            text-align: center;
            margin-top: 1rem;
            margin-bottom: 1rem
        }

        .dijo.title {
            max-width: 20rem
        }
    </style>
</head>

<body>
    <h1>Han pasado</h1>
    <div class="elements">
        <p class="dijo element">{{ $said }}</p>
        <h2 class="dijo title">
            días desde que Midzui dijo que volvía a hacer streams "esta vez para siempre"
        </h2>
        <p class="stream element">{{ $last_stream }}</p>
        <h2 class="stream title">días desde el último stream</h2>
    </div>
</body>

</html>
