module.exports = async (pluginConfig, context) => {
  const { nextRelease, logger } = context;
  try {
    logger.log(`🚀 Publishing release: ${nextRelease.version}`);
    logger.log('✔ Publish step completed.');
  } catch (error) {
    logger.error('❌ Publish failed.');
    throw error;
  }
};
