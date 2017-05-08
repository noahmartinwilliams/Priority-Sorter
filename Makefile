HC=ghc --make $@

Sorter: Sorter.hs
	$(HC)

.PHONY: clean
clean:
	rm *.o || true
	rm *.hi || true
	rm Sorter || true
