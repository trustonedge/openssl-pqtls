INCLUDES := -Iinclude
LIBS := -lssl -lcrypto 

all:
	gcc -g -c $(INCLUDES) -o common.o common.c
	gcc -g $(INCLUDES) -o client/client.out client/main.c common.o $(LIBS)
	gcc -g $(INCLUDES) -o server/server.out server/main.c common.o $(LIBS)

clean:
	find . -type f \( -name "*.o" -o -name "*.out" \) -delete