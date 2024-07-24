.PHONY: test watch coverage

test:
	forge test
watch:
	forge test -vvvv
coverage:
	forge coverage --report=summary
debug:
	forge coverage --report=debug --report-file=coverage.txt