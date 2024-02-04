## Account setup

1. Install AWS CLI (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

2. Run the following command:

    ```bash
    aws configure sso
    ```

    You will be prompted to provide the following information:

    - SSO start URL: `https://where2eat.awsapps.com/start`
    - SSO Region: `us-east-1`

    This will open a new tab in your default web browser.

3. Follow the instructions in the new tab to set up your account.

4. You will then be prompted to provide the following default settings:

    - CLI default client Region and default output format, both can be empty
    - CLI profile name: This is what you will use to specify to use this profile in the command line

The `cdk.json` file tells the CDK Toolkit how to execute your app.

## Useful commands

* `npm run build`   compile typescript to js
* `npm run watch`   watch for changes and compile
* `npm run test`    perform the jest unit tests
* `npx cdk deploy`  deploy this stack to your default AWS account/region
* `npx cdk diff`    compare deployed stack with current state
* `npx cdk synth`   emits the synthesized CloudFormation template
