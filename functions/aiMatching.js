const { OpenAI } = require('openai');
const axios = require('axios');

// Initialize OpenAI (or you can use Google Vertex AI)
// For production, store API key in Firebase Functions config:
// firebase functions:config:set openai.key="YOUR_API_KEY"
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY || ''
});

/**
 * Generate text embedding using OpenAI API
 * You can replace this with Google Vertex AI or other embedding services
 */
async function generateEmbedding(text) {
  try {
    // Clean and truncate text if needed
    const cleanText = text.trim().substring(0, 8000);

    if (!cleanText) {
      console.warn('Empty text provided for embedding generation');
      return null;
    }

    // Using OpenAI's text-embedding-3-small model
    const response = await openai.embeddings.create({
      model: 'text-embedding-3-small',
      input: cleanText,
      encoding_format: 'float'
    });

    return response.data[0].embedding;
  } catch (error) {
    console.error('Error generating embedding:', error);

    // Fallback: return null or throw error based on your needs
    return null;
  }
}

/**
 * Alternative: Generate embedding using Google Vertex AI
 * Uncomment and configure if you prefer Google's embedding service
 */
async function generateEmbeddingVertexAI(text, projectId, location = 'us-central1') {
  try {
    const cleanText = text.trim().substring(0, 8000);

    if (!cleanText) {
      return null;
    }

    const endpoint = `https://${location}-aiplatform.googleapis.com/v1/projects/${projectId}/locations/${location}/publishers/google/models/textembedding-gecko:predict`;

    const { GoogleAuth } = require('google-auth-library');
    const auth = new GoogleAuth({
      scopes: 'https://www.googleapis.com/auth/cloud-platform'
    });

    const client = await auth.getClient();
    const accessToken = await client.getAccessToken();

    const response = await axios.post(
      endpoint,
      {
        instances: [
          {
            content: cleanText
          }
        ]
      },
      {
        headers: {
          'Authorization': `Bearer ${accessToken.token}`,
          'Content-Type': 'application/json'
        }
      }
    );

    return response.data.predictions[0].embeddings.values;
  } catch (error) {
    console.error('Error generating embedding with Vertex AI:', error);
    return null;
  }
}

/**
 * Compute cosine similarity between two embedding vectors
 */
function computeCosineSimilarity(vectorA, vectorB) {
  if (!vectorA || !vectorB || vectorA.length !== vectorB.length) {
    return 0;
  }

  let dotProduct = 0;
  let normA = 0;
  let normB = 0;

  for (let i = 0; i < vectorA.length; i++) {
    dotProduct += vectorA[i] * vectorB[i];
    normA += vectorA[i] * vectorA[i];
    normB += vectorB[i] * vectorB[i];
  }

  normA = Math.sqrt(normA);
  normB = Math.sqrt(normB);

  if (normA === 0 || normB === 0) {
    return 0;
  }

  return dotProduct / (normA * normB);
}

/**
 * Compute Euclidean distance between two vectors (alternative metric)
 */
function computeEuclideanDistance(vectorA, vectorB) {
  if (!vectorA || !vectorB || vectorA.length !== vectorB.length) {
    return Infinity;
  }

  let sum = 0;
  for (let i = 0; i < vectorA.length; i++) {
    const diff = vectorA[i] - vectorB[i];
    sum += diff * diff;
  }

  return Math.sqrt(sum);
}

module.exports = {
  generateEmbedding,
  generateEmbeddingVertexAI,
  computeCosineSimilarity,
  computeEuclideanDistance
};
