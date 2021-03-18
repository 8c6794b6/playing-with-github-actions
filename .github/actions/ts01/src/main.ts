import * as core from "@actions/core";
import * as github from "@actions/github";

async function run(): Promise<void> {
    try {
        const nameToGreet : string = core.getInput("who-to-greet");
        core.info(`Hello ${nameToGreet}!`);

        const time : string = new Date().toTimeString();
        core.setOutput("time", time);

        const payload : string =
            JSON.stringify(github.context.payload, undefined, 2);
        core.info(`The event payload: ${payload}`);
    } catch (error) {
        core.setFailed(error.message);
    }
}

run();
