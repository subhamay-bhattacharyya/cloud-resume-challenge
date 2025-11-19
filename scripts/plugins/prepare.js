const fs = require('fs');
const path = require('path');

module.exports = {
  prepare: async (pluginConfig, context) => {
    const { nextRelease, logger } = context;

    try {
      logger.log('⚙️ Preparing release...');
      if (!nextRelease || !nextRelease.version) {
        throw new Error('nextRelease.version is undefined');
      }

      const versionFile = path.resolve(__dirname, '../../VERSION');
      fs.writeFileSync(versionFile, `${nextRelease.version}\n`);

      const summaryPath = process.env.GITHUB_STEP_SUMMARY;
      if (summaryPath) {
        fs.appendFileSync(summaryPath, `### ✅ Semantic Release\n\n`);
        fs.appendFileSync(summaryPath, `**Released Version:** \\${nextRelease.version}\n`);
      }

      logger.log(`✔ VERSION file updated to ${nextRelease.version}`);
    } catch (error) {
      logger.error('❌ Failed to prepare release.');
      throw error;
    }
  }
};
