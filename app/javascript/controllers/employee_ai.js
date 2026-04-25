document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("#employee-ai-form");
  if (!form) return;

  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const formData = new FormData(form);

    const response = await fetch(form.action, {
      method: "POST",
      body: formData
    });

    const data = await response.json();

    // Insert AI reply into chat
    const container = document.querySelector(".message-card");
    if (container) {
      container.innerHTML += `
        <div class="assistant-msg">
          <strong>Assistant:</strong> ${data.reply}
        </div>
      `;
    }

    // Clear textarea
    form.querySelector("textarea").value = "";
  });
});
