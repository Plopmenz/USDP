import { Address, Deployer } from "../web3webdeploy/types";

export interface DeploymentSettings {
  forceRedeploy?: boolean;
}

export interface Deployment {
  usdp: Address;
}

export async function deploy(
  deployer: Deployer,
  settings?: DeploymentSettings
): Promise<Deployment> {
  if (settings?.forceRedeploy !== undefined && !settings.forceRedeploy) {
    const existingDeployment = await deployer.loadDeployment({
      deploymentName: "usdp.json",
    });
    if (existingDeployment !== undefined) {
      return existingDeployment;
    }
  }

  const usdp = await deployer
    .deploy({
      id: "USDP",
      contract: "USDP",
    })
    .then((deployment) => deployment.address);
  const deployment = {
    usdp,
  };
  await deployer.saveDeployment({
    deploymentName: "usdp.json",
    deployment: deployment,
  });
  return deployment;
}
