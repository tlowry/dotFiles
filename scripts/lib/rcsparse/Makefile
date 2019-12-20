LDFLAGS=-L~/cpython -lpython2.7 -shared
CFLAGS=-DCONFIG_64 -D_GNU_SOURCE -I ~/cpython -I ~/cpython/Include -I ~/cpython/Modules/_decimal/libmpdec -I ~/ruby/include -fPIC

objects=rcsparse.o py-rcsparse.o

rcsparse.so: $(objects)
	cc -o $(objects)

.PHONY : clean
clean:
	rm rcsparse.so $(objects)
