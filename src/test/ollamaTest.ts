// make sure you have ollama installed in your system and you run `ollama run llama3.1`

import ollama from 'ollama';

(async () => {
  try {
    const response = await ollama.chat({
      model: 'llama3.1',
      messages: [{ role: 'user', content: 'Why is the sky blue?' }],
    });
    console.log(response.message.content);
  } catch (error) {
    console.error('Error:', error);
  }
})();
