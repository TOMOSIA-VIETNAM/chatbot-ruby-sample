module.exports = function (shipit) {
  require('shipit-deploy')(shipit);

  shipit.initConfig({
    default: {
      workspace: '.',
      keepWorkspace: true,
      repositoryUrl: false,
      ignores: ['.git', 'node_modules', '.env'],
      deleteOnRollback: false,
      keepReleases: 2,
      shallowClone: false,
    },
    client: {
      deployTo: '/home/ubuntu/openai/client',
      servers: 'ubuntu@54.238.12.231',
      key: '~/.ssh/qr_code/qlear-release.pem',
      dirToCopy: '../dist',
    },
    server: {
      deployTo: '/home/ubuntu/openai/server',
      servers: 'ubuntu@54.238.12.231',
      key: '~/.ssh/qr_code/qlear-release.pem',
      dirToCopy: '../server',
    }
  });
};

