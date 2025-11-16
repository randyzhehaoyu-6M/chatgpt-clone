'use client'

import { useState, useEffect } from 'react'

interface SystemMessageEditorProps {
  systemMessage?: string
  onSave: (message: string) => void
  onClose: () => void
}

export default function SystemMessageEditor({
  systemMessage = '',
  onSave,
  onClose,
}: SystemMessageEditorProps) {
  const [message, setMessage] = useState(systemMessage)

  useEffect(() => {
    setMessage(systemMessage)
  }, [systemMessage])

  const handleSave = () => {
    onSave(message.trim())
    onClose()
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div className="bg-white dark:bg-gray-800 rounded-lg p-6 w-full max-w-2xl mx-4 shadow-xl">
        <h2 className="text-xl font-semibold mb-4 text-gray-800 dark:text-white">
          System Instructions
        </h2>
        <p className="text-sm text-gray-600 dark:text-gray-400 mb-4">
          Add system-level instructions that will guide the AI's behavior throughout this conversation.
          For example: "You are a helpful coding assistant. Always provide code examples when explaining concepts."
        </p>
        <textarea
          value={message}
          onChange={(e) => setMessage(e.target.value)}
          placeholder="Enter system instructions (optional)..."
          className="w-full h-32 p-3 border border-gray-300 dark:border-gray-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white resize-none"
        />
        <div className="flex justify-end gap-2 mt-4">
          <button
            onClick={onClose}
            className="px-4 py-2 text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg transition-colors"
          >
            Cancel
          </button>
          <button
            onClick={handleSave}
            className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
          >
            Save
          </button>
        </div>
      </div>
    </div>
  )
}

