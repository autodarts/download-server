FROM alpine

COPY ./.bin/main-linux /main

CMD ./main
