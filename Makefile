all: cv.css index.html

clean:
	rm cv.css index.html

%.html: %.in.html
	tidy -q -ashtml -w 0 -o "$@" "$<"

%.css: %.less
	lessc --yui-compress "$<" "$@"

.PHONY: all clean

# vim:noet
