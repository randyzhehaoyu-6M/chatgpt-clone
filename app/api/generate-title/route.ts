import { NextRequest, NextResponse } from 'next/server'
import OpenAI from 'openai'

const openai = new OpenAI({
  baseURL: process.env.NEXT_PUBLIC_API_BASE_URL + '/v1',
  apiKey: process.env.AI_BUILDER_TOKEN,
})

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { firstMessage } = body

    if (!firstMessage || typeof firstMessage !== 'string') {
      return NextResponse.json(
        { error: 'First message is required' },
        { status: 400 }
      )
    }

    // Generate a concise title from the first message
    const completion = await openai.chat.completions.create({
      model: 'grok-4-fast',
      messages: [
        {
          role: 'system',
          content: 'You are a helpful assistant that generates concise, descriptive titles (max 5-6 words) for conversations based on the first user message. Return only the title, nothing else.',
        },
        {
          role: 'user',
          content: `Generate a short title for this conversation starter: "${firstMessage}"`,
        },
      ],
      temperature: 0.7,
      max_tokens: 20,
    })

    const title = completion.choices[0]?.message?.content?.trim() || firstMessage.substring(0, 50)

    return NextResponse.json({ title })
  } catch (error: any) {
    console.error('Error generating title:', error)
    // Fallback to truncated message
    const fallbackTitle = body.firstMessage?.substring(0, 50) || 'New Conversation'
    return NextResponse.json({ title: fallbackTitle })
  }
}

