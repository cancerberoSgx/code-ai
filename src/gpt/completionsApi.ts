import axios from 'axios';
import { ChatMessage, OpenAiConfig } from '../tool/types';

interface ChatCompletionArgs {
  prompt: string;
  systemPrompt?: string;
  config: OpenAiConfig;
}

/** high level function to reqeust chat completions */
export async function chatCompletion(args: ChatCompletionArgs): Promise<string> {
  const messages: ChatMessage[] = [
    { role: 'system', content: args.systemPrompt || 'You are an expert developer' },
    { role: 'user', content: args.prompt },
  ];
  const assistantMessage = await getChatCompletion(messages, args.config);
  return assistantMessage.content;
}

// Define the API endpoint and API key
const OPENAI_API_ENDPOINT = 'https://api.openai.com/v1/chat/completions';

// Define the type for the response
export interface OpenAIResponse {
  id: string;
  object: string;
  created: number;
  choices: Array<{
    index: number;
    message: ChatMessage;
    finish_reason: string;
  }>;
  usage: {
    prompt_tokens: number;
    completion_tokens: number;
    total_tokens: number;
  };
}

/** Function to call OpenAI Chat Completion API */
export async function getChatCompletion(messages: ChatMessage[], config: OpenAiConfig): Promise<ChatMessage> {
  try {
    const response = await axios.post<OpenAIResponse>(
      OPENAI_API_ENDPOINT,
      {
        model: config.model,
        messages: messages,
      },
      {
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${config.apiKey}`,
        },
      }
    );
    const assistantMessage = response.data.choices[0].message;
    return assistantMessage;
  } catch (error: any) {
    throw new Error(`Error calling OpenAI API: status=${error.response?.status} body=${JSON.stringify(error.response?.data)}`);
  }
}
