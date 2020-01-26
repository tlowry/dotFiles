PYTHON_DIR=/home/tony/cpython
RUBY_DIR=/home/tony/ruby

LDFLAGS=-L$(PYTHON_DIR) -L$(RUBY_DIR)
LDLIBS=-lpython2.7 -lruby-static
CFLAGS=-I $(PYTHON_DIR) -I $(PYTHON_DIR)/Include -I $(PYTHON_DIR)/Modules/_decimal/libmpdec -I $(RUBY_DIR)/include -I $(RUBY_DIR)/.ext/include/x86_64-linux/ -DCONFIG_64 -D_GNU_SOURCE -shared -fPIC

objects=rcsparse.o py-rcsparse.o rb-rcsparse.o

rcsparse.so: librcsparse_ar.a
	cc $(LDFLAGS) -L. $(LDLIBS) -lrcsparse_ar -rdynamic -shared -o rcsparse.so $(objects)

librcsparse_ar.a: $(objects)
	ar rcs librcsparse_ar.a $(objects) $(RUBY_DIR)/libruby-static.a

.PHONY : clean
clean:
	rm -f rcsparse.so $(objects)
