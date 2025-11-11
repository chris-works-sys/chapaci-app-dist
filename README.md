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


gttsSpeak(text).then(() => {
          console.log("Fala concluída via gTTS.");
        }).catch((e) => {
          console.error("Erro na fala via gTTS:", e);
        });


function edgeSpeak(text) {
        return fetch('http://127.0.0.1:3000/api/tts', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ text, language: 'pt-BR' })
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
