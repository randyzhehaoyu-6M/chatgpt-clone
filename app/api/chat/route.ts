import { NextRequest, NextResponse } from 'next/server'
import OpenAI from 'openai'

const openai = new OpenAI({
  baseURL: process.env.NEXT_PUBLIC_API_BASE_URL + '/v1',
  apiKey: process.env.AI_BUILDER_TOKEN,
})

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { messages, model = 'grok-4-fast' } = body

    if (!messages || !Array.isArray(messages)) {
      return NextResponse.json(
        { error: 'Messages array is required' },
        { status: 400 }
      )
    }

    const completion = await openai.chat.completions.create({
      model,
      messages: messages.map((msg: { role: string; content: string }) => ({
        role: msg.role as 'system' | 'user' | 'assistant',
        content: msg.content,
      })),
      temperature: 0.7,
      max_tokens: 1024,
    })

    const responseContent = completion.choices[0]?.message?.content || ''

    return NextResponse.json({
      content: responseContent,
      usage: completion.usage,
    })
  } catch (error: any) {
    console.error('Error in chat API:', error)
    return NextResponse.json(
      {
        error: 'Failed to process chat request',
        details: error.message || 'Unknown error',
      },
      { status: 500 }
    )
  }
}

