import 'package:google_generative_ai/google_generative_ai.dart'
    show GenerativeModel, Content, GenerationConfig;
import 'package:medora/core/constants/keys/app_keys.dart'
    show AppKeys;

class GeminiModelFactory {
  static GenerativeModel create({
    required Content instruction,
    //  String modelName = 'gemini-2.5-flash',
    //   String modelName = 'gemini-1.5-flash',
  //  String modelName = 'gemini-3-flash-preview',
 required   String modelName  ,
  }) {
    return GenerativeModel(
      model: modelName,
      apiKey: AppKeys.googleGeminiKey,

      generationConfig: GenerationConfig(
        temperature: 0.1,
        maxOutputTokens: 1082,
        topP: 0.8,
        topK: 40,
      ),
      systemInstruction: instruction,
    );
  }
}
