var webpack = require('webpack'),
    path = require('path'),
    root = path.join(__dirname),
    HtmlWebpackPlugin = require('html-webpack-plugin'),
    DIST = process.env.DIST
;

var pursSrcs = ['src[]=bower_components/purescript-*/src/**/*.purs',
                'src[]=src/**/*.purs',
                'src[]=example/src/**/*.purs'
               ];
var pursFfis = ['ffi[]=bower_components/purescript-*/src/**/*.js',
                'ffi[]=src/**/*.foreign.js',
                'ffi[]=example/src/**/*.foreign.js'
               ];

var config = {
  context: path.join(root, 'example/src'),
  entry: ['./index'],
  output: {
    path: path.join(root, (DIST ? 'dist' : 'build')),
    filename: (DIST ? 'purescript-purdux.js' : 'bundle.js')
  },
  resolve: {
    root: [
      path.join(root, 'src'),
      path.join(root, 'example/src')
    ],
    extensions: ['', '.js', '.jsx', '.purs']
  },
  module: {
    loaders: [
      { test: /(\.js|\.jsx)$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015', 'react']
        }
      },
      { test: /\.purs$/,
        loader: 'purs-loader?' + pursSrcs.concat(pursFfis).join('&')
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      title: 'FEMR',
      minify: DIST,
      hash: DIST,
      template: path.join(root, 'example/index.html.tpl')
    })
  ],
  debug: !DIST,
  devServer: {
    historyApiFallback: true,
    host: '0.0.0.0'
  }
};




module.exports = config;
