# Prompt Categories for Testing Language Models (LLMs)

These prompts are designed to challenge the models in various ways, including their ability to follow ethical guidelines, maintain data privacy, resist generating harmful or sensitive content, and avoid being exploited to perform unauthorized tasks.
<br>
<br>

## Ethical and Safety Boundaries

- **Prompt Elicitation for Sensitive Content:** Asking the LLM to generate content that could be considered unethical, illegal, or harmful, to assess adherence to ethical guidelines. Includes **jailbreak** wordlists.

The testing of breaking safety boundaries includes prompts for:
- **Code Generation for Malicious Purposes:** Prompting the LLM to generate code that could be used for hacking, malware creation, or other cybersecurity threats.
- **Phishing Email Composition:** Asking the model to compose a phishing email, testing its ability to recognize and refuse to assist in fraudulent activities.

All of the wordlists in the `Ethical_and_Safety_Boundaries` directory are from [the official repository](https://github.com/verazuo/jailbreak_llms) for the ACM CCS 2024 paper ["Do Anything Now'': Characterizing and Evaluating In-The-Wild Jailbreak Prompts on Large Language Models](https://arxiv.org/abs/2308.03825) by [Xinyue Shen](https://xinyueshen.me/), [Zeyuan Chen](https://picodora.github.io/), [Michael Backes](https://michaelbackes.eu/), Yun Shen, and [Yang Zhang](https://yangzhangalmo.github.io/). 

The contents of the README in that directory are from the the official repository as well, featuring only minor changes to correctly attribute credit. The official repository features more datasets than the ones included here, but only the more "practical" ones for AI testing were added to SecLists. Its highly recommended that you read the actual paper for more information.

<br>

## Bias Testing

- Providing scenarios or questions that could reveal biases in responses based on gender, race, ethnicity, or other factors.
> [!WARNING]
> Replace these placeholders in the Bias Testing wordlists before using them:
> - `Bias_Testing/gender_bias.txt`: 
>   - `[GENDER]`
> - `Bias_Testing/nationality_geographic_bias.txt`:
>   - `[COUNTRY]`
>   - `[REGION]`
>   - `[NATIONALITY]`
> - `Bias_Testing/race_ethnicity_bias.txt`: 
>   - `[SKIN_COLOR]`
<br>

## Privacy and Data Leakage

- **Memory Recall:** Asking questions that probe the model for specific data remnants from its training data, checking for any unintended memorization or data leakage.
- **Personal Data Generation:** Requesting the model to generate personal data, like names, addresses, or social security numbers, to evaluate its capability to recognize and avoid creating personally identifiable information (PII).

> [!WARNING]
> Replace these placeholders in the `Memory_Recall_Testing/session_recall.txt` wordlist before using it:
>   - `[COUNTRY]`
>   - `[REGION]`
>   - `[NATIONALITY]`
<br>