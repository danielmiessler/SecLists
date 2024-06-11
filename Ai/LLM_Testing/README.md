# Prompt Categories for Testing Language Models (LLMs)

These prompts are designed to challenge the models in various ways, including their ability to follow ethical guidelines, maintain data privacy, resist generating harmful or sensitive content, and avoid being exploited to perform unauthorized tasks.
<br>
<br>

## Ethical and Safety Boundaries

- **Prompt Elicitation for Sensitive Content:** Asking the LLM to generate content that could be considered unethical, illegal, or harmful, to assess adherence to ethical guidelines.
<br>

## Bias Testing

- Providing scenarios or questions that could reveal biases in responses based on gender, race, ethnicity, or other factors.
> [!WARNING]
> Replace these placeholders in the Bias Testing wordlists before using them:
> - `Bias_Testing/gender_bias.txt`: **[GENDER]**
> - `Bias_Testing/nationality_geographic_bias.txt`:
>   - **[COUNTRY]**
>   - **[REGION]**
>   - **[NATIONALITY]**
> - `Bias_Testing/race_ethnicity_bias.txt`: **[SKIN_COLOR]**
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

## Security and Misuse

- **Code Generation for Malicious Purposes:** Prompting the LLM to generate code that could be used for hacking, malware creation, or other cybersecurity threats.
- **Phishing Email Composition:** Asking the model to compose a phishing email, testing its ability to recognize and refuse to assist in fraudulent activities.
<br>

## Technical Capabilities and Limitations

- **Advanced Technical Questions:** Asking complex questions related to specialized fields (e.g., cybersecurity, medicine, law) to test the model's depth of knowledge and accuracy.
- **Problem-Solving and Debugging Tasks:** Requesting assistance with debugging code or solving technical problems to evaluate the model's practical utility and accuracy in technical domains.
<br>

## Compliance and Ethical Hacking

- **Security Vulnerability Identification:** Asking the model to identify potential security vulnerabilities in a given piece of code or system configuration, testing its ability to assist in ethical hacking activities without promoting actual harm.
- **Compliance with Legal and Ethical Guidelines:** Prompting the model with questions that test its knowledge and adherence to legal and ethical standards in cybersecurity practices.
<br>

## Custom Scenario Testing

- **Red Team Operation Simulations:** Creating scenarios where the LLM needs to propose hypothetical red team strategies for educational purposes, ensuring it provides information in a way that's aligned with ethical hacking principles and not actual attack planning.

