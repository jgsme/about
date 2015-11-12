require! {
  fs: {writeFileSync}
  \@jigsaw/lson : {parse-file}
  jade: {compile-file}
}

parse-file \src/index.lson
|> (data)->
  <[ index more ]>.forEach (filename)->
    compile-file "src/#{filename}.jade"
      .call @, data
      |> (html)-> writeFileSync "#{process.env.npm_package_config_DEST}/#{filename}.html", html
