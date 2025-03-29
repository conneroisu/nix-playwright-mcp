import process from 'node:process'
import { chromium } from 'playwright-core'
import yargs from 'yargs'
import { hideBin } from 'yargs/helpers'

const defaultBrowser = process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH

// Parse command line arguments
const argv = yargs(hideBin(process.argv))
  .option('port', {
    description: 'Port to run the server on',
    type: 'number',
    default: 0,
  })
  .option('host', {
    description: 'Host to bind the server to',
    type: 'string',
    default: '127.0.0.1',
  })
  .option('headless', {
    description: 'Run browser in headless mode',
    type: 'boolean',
    default: false,
  })
  .option('sandbox', {
    description: 'Enable sandboxing of the Chromium session',
    type: 'boolean',
    default: true,
  })
  .option('browser-executable', {
    description: 'Path to browser executable',
    type: 'string',
    default: defaultBrowser,
  })
  .help()
  .alias('help', 'h')
  .version()
  .alias('version', 'v')
  .parse()

async function main() {
  try {
    const browserServer = await chromium.launchServer({
      channel: 'chrome',
      executablePath: argv.browserExecutable,
      chromiumSandbox: argv.sandbox,
      headless: argv.headless,
      handleSIGINT: true,
      host: argv.host,
      port: argv.port,
      wsPath: '/',
    })

    const wsEndpoint = browserServer.wsEndpoint()
    console.log(`Playwright WebSocket server running on ${wsEndpoint}`)
  }
  catch (error) {
    console.error('Failed to start Playwright WebSocket server:', error)
  }
}

main()
