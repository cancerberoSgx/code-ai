import { handleCli } from '.';

(async () => {
  try {
    await handleCli();
    process.exit(0);
  } catch (error) {
    console.log('ERROR', error);
    process.exit(1);
  }
})();
