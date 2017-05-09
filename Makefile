HC=ghc --make $@

Prioritizer: Prioritizer.hs
	$(HC)

.PHONY: clean
clean:
	rm *.o || true
	rm *.hi || true
	rm Prioritizer || true
