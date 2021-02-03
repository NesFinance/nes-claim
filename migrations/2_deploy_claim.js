const Claim = artifacts.require('./Claim.sol')

module.exports = async function (deployer) {
    await deployer.deploy(Claim, process.env.CONTROLLER)
}