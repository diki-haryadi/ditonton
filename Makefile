.PHONY: clean test build-runner

clean:
	@echo "Cleaning generated files..."
	@flutter clean
	@rm -rf coverage
build-mock:
	@flutter pub run build_runner build
build-runner:
	@echo "Generating mocks..."
	@flutter pub run build_runner build --delete-conflicting-outputs
test-file:
	@flutter test test/domain/usecases/get_tv_series_detail_test.dart
test:
	@echo "Running tests..."
	@flutter test --coverage

all: clean build-runner test
	@echo "All tasks completed successfully!"