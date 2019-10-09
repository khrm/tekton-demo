#!/usr/bin/env sh
wiki_pid=
cleanup() {
        kill $wiki_pid
        rm -f test_*.out Test.txt final-test.go final-test.bin final-test-port.txt a.out get.bin
}
trap cleanup 0 INT

if [ ! -f ./main ]; then
    go build -o ./main ..
fi


./main &
wiki_pid=$!
go build -o get.bin e2e/get.go

./get.bin -post=body=some%20content http://127.0.0.1:8080/save/Test > test_save.out
diff -u test_save.out e2e/test_view.good # should be the same as viewing
if [ $? -ne 0 ]
then
    echo "failed"
    exit 1
fi
diff -u Test.txt e2e/test_Test.txt.good
if [ $? -ne 0 ]
then
    echo "failed"
    exit 1
fi
./get.bin http://127.0.0.1:8080/view/Test > test_view.out
diff -u test_view.out e2e/test_view.good
if [ $? -ne 0 ]
then
    echo "failed"
    exit 1
fi
echo PASS
