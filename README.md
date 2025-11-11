function gttsSpeak(text) {
        return fetch('/api/tts', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ text, language: 'pt-br' })
        })
        .then(response => response.blob())
        .then(blob => {
          const url = URL.createObjectURL(blob);
          const audio = new Audio(url);
          return new Promise((resolve, reject) => {
            audio.onended = () => {
              URL.revokeObjectURL(url);
              resolve();
            };
            audio.onerror = (e) => {
              URL.revokeObjectURL(url);
              reject(e);
            };
            audio.play();
          });
        });
      }
