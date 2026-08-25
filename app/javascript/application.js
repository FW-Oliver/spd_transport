// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
let bellAudioContext = null

function playBell() {
  if (!bellAudioContext) return

  const now = bellAudioContext.currentTime

  const oscillator = bellAudioContext.createOscillator()
  const gain = bellAudioContext.createGain()

  oscillator.type = "sine"
  oscillator.frequency.setValueAtTime(880, now)
  oscillator.frequency.setValueAtTime(1174.66, now + 0.12)

  gain.gain.setValueAtTime(0.0001, now)
  gain.gain.exponentialRampToValueAtTime(0.25, now + 0.01)
  gain.gain.exponentialRampToValueAtTime(0.0001, now + 0.6)

  oscillator.connect(gain)
  gain.connect(bellAudioContext.destination)

  oscillator.start(now)
  oscillator.stop(now + 0.6)
}

document.addEventListener("turbo:load", () => {
  const enableBellButton = document.getElementById("enable-bell")

  if (!enableBellButton) return

  enableBellButton.addEventListener("click", async () => {
    bellAudioContext ||= new AudioContext()

    await bellAudioContext.resume()

    playBell()

    enableBellButton.textContent = "🔔 Bell Enabled"
    enableBellButton.disabled = true
  })
})

document.addEventListener("turbo:before-stream-render", () => {
  playBell()
})
