HC=ghc --make $@

.PHONY: clean install
install: Prioritizer
	install Prioritizer /usr/bin/prioritizer
	install prioritizer.1 /usr/share/man/man1/prioritizer.1

Prioritizer: Prioritizer.hs
	$(HC)

clean:
	rm *.o || true
	rm *.hi || true
	rm Prioritizer || true
