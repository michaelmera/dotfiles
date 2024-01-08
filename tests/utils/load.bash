function assert_variable {
    if [ -z ${!1+x} ]; then
        printf 'expected non-null variable %s (was not set)\n' "$1" \
        | batslib_decorate 'ERROR: assert_variable' \
        | fail
    elif [ -z ${!1} ]; then
        printf 'expected non-null variable %s (was set but null)\n' "$1" \
        | batslib_decorate 'ERROR: assert_variable' \
        | fail
    fi
}
