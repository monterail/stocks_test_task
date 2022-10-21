# How to run

Clone repository to your local machine, keep in mind that you must have [Flutter installed](https://docs.flutter.dev/get-started/install?gclid=Cj0KCQjwhsmaBhCvARIsAIbEbH5b_q4T1GvZIVy7qqroZR_u0QbbAxdgEb9mHnfl3bgQI9619xkIqC8aAj7EEALw_wcB&gclsrc=aw.ds) there in order to run it.

```shell
git clone https://github.com/monterail/stocks_test_task.git
```
Then go to the directory where you've cloned project
```shell
cd stocks_test_task
```
Install dependencies
```shell
flutter pub get
```
Run script that will create generic code
```shell
make generate-code
```
Go to the [polygon.io](https://polygon.io/) and get API key (it is free). Then you have to put this API key to the environment variable.

Go to the `environment/.prod-variables` in project directory and put api key in the `POLYGON_API_KEY_PROD` variable

Connect your device to the computer and run the script below, connecting device is not neccesery, if you will run the script without it, the web version will start
```shell
make run-prod
```
It will build the production version of application and install it to connected device, please keep in mind, that production version cannot be installed to the IOS simulator.