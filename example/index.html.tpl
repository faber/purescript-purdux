<!DOCTYPE html>
<html{% if(o.htmlWebpackPlugin.files.manifest) { %} manifest="{%= o.htmlWebpackPlugin.files.manifest %}"{% } %}>
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <meta name="HandheldFriendly" content="true">
    <meta name="MobileOptimized" content="width">

    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">

    <link rel="apple-touch-icon" href="apple-touch-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="72x72" href="apple-touch-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="114x114" href="apple-touch-icon-114x114.png">
    <link rel="apple-touch-startup-image" href="splash-startup.png">

    <title>{%=o.htmlWebpackPlugin.options.title || 'Webpack App'%}</title>
    {% if (o.htmlWebpackPlugin.files.favicon) { %}
    <link rel="shortcut icon" href="{%=o.htmlWebpackPlugin.files.favicon%}">
    {% } %}

    {% for (var css in o.htmlWebpackPlugin.files.css) { %}
    <link href="/{%=o.htmlWebpackPlugin.files.css[css] %}" rel="stylesheet">
    {% } %}
  </head>

  <body>
    <div id="body"></div>
    {% for (var chunk in o.htmlWebpackPlugin.files.chunks) { %}
    <script src="/{%=o.htmlWebpackPlugin.files.chunks[chunk].entry %}"></script>
    {% } %}
  </body>
</html>
