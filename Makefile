HC=ghc --make $@

.PHONY: clean install
install: Prioritizer
	install Prioritizer /usr/bin/prioritizer

Prioritizer: Prioritizer.hs
	$(HC)

clean:
	rm *.o || true
	rm *.hi || true
	rm Prioritizer || true
