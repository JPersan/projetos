const { setHeadlessWhen } = require('@codeceptjs/configure');

setHeadlessWhen(process.env.HEADLESS);

exports.config = {
  tests: 'tests/api/*_test.js',
  output: './report',
  helpers: {
    REST: {
			endpoint: "https://swapi.dev",
			onRequest: () => {
				//request.headers.auth = "123";
			}
    }
  },
  include: {
    I: './steps_file.js'
  },
  bootstrap: null,
  mocha: {
    "reporterOptions": {
      "reportDir": "report"
    }
  },
  name: 'StarWars',
  plugins: {
    retryFailedStep: {
      enabled: true
    },
    screenshotOnFail: {
      enabled: true
    }
  }
}