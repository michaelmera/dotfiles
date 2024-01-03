#!/usr/bin/env bats

setup() {
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"

    load "${DIR}/bats-support/load"
    load "${DIR}/bats-assert/load"
    load "${DIR}/utils/load"
}

@test "XDG_CONFIG_HOME is set and non-null" {
    assert_variable XDG_CONFIG_HOME is_non_null
}
