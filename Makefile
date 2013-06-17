BUILD=build
STATIC=static

OUTPUTS=$(addprefix $(BUILD)/, cv.css index.html)

all: $(OUTPUTS) static

clean:
	rm -rf $(OUTPUTS)
	rm -rf $(BUILD) 

# Update the build directory from the static directory via rsync
static: $(BUILD)
	rsync -r $(STATIC)/ $(BUILD)

github: all
	ghp-import "$(BUILD)"
	git push origin gh-pages

deploy: all
	rsync -rz --chmod=Dugo+rx,ugo+r --perms $(BUILD)/ richwareham.com:/var/www/richwareham.com/htdocs/cv

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/%.html: %.in.html $(BUILD)
	tidy -q -ashtml -w 0 -o "$@" "$<"

$(BUILD)/%.css: %.less $(BUILD)
	lessc --yui-compress "$<" >"$@"

.PHONY: all clean deploy static

# vim:noet
