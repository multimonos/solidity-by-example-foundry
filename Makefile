.PHONY: test watch coverage

test:
	forge test
watch:
	forge test -vv --watch
coverage:
	forge coverage --report=summary
debug:
	forge coverage --report=debug --report-file=coverage.txt
