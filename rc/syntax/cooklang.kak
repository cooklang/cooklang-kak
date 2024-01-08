# http://cooklang.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](cook) %{
    set-option buffer filetype cooklang
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=cooklang %{
    require-module cooklang
}

hook -group cooklang-highlight global WinSetOption filetype=cooklang %{
    add-highlighter window/cooklang ref cooklang
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/cooklang }
}

provide-module cooklang %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/cooklang regions
add-highlighter shared/cooklang/text default-region group

add-highlighter shared/cooklang/line_comment region -- $ fill comment
add-highlighter shared/cooklang/comment region \[- -\] fill comment

add-highlighter shared/cooklang/metadata region ^>> $ fill meta

add-highlighter shared/cooklang/text/ingredient regex \
    "(@[A-Za-z ]*\{[^\{\}]*\})|(@[A-Za-z]*)" 0:value

add-highlighter shared/cooklang/text/cookware regex \
    "(#[A-Za-z ]*\{[^\{\}]*\})|(#[A-Za-z]*)" 0:variable

add-highlighter shared/cooklang/timer region (~) (\{[^\{\}]*\}) fill module
}
