find . -type f -print0 | xargs -0 md5sum | \
    sed -r 's/^([0-9a-f]{32})  (.*)/"\2","\1"/' > out.csv