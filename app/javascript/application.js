import "@hotwired/turbo-rails"

import "controllers"

const SOUND_STORAGE_KEY = "spdTransportSoundEnabled"

let soundEnabled = localStorage.getItem(SOUND_STORAGE_KEY) !== "false"

let announcementAudio = null
let cancelledAudio = null

function initializeAudio() {
  const audioContainer = document.getElementById("spd-transport-audio")

  if (!audioContainer) return

  announcementAudio = new Audio(audioContainer.dataset.announcement)
  cancelledAudio = new Audio(audioContainer.dataset.cancelled)

  announcementAudio.preload = "auto"
  cancelledAudio.preload = "auto"
}

function updateSoundButton() {
  const button = document.getElementById("enable-bell")
  if (!button) return

  button.textContent = soundEnabled
    ? "🔊 Sound Alerts: ON"
    : "🔇 Sound Alerts: OFF"
}

async function enableSound() {
  if (!announcementAudio) initializeAudio()

  if (!announcementAudio) return

  try {
    await announcementAudio.play()

    announcementAudio.pause()
    announcementAudio.currentTime = 0

    soundEnabled = true
    localStorage.setItem(SOUND_STORAGE_KEY, "true")

    updateSoundButton()
  } catch (error) {
    console.warn("Unable to enable transport sound:", error)
  }
}

function toggleSound() {
  if (soundEnabled) {
    soundEnabled = false
    localStorage.setItem(SOUND_STORAGE_KEY, "false")
  } else {
    enableSound()
    return
  }

  updateSoundButton()
}

function playAudio(audio) {
  if (!soundEnabled || !audio) return

  audio.currentTime = 0

  audio.play().catch((error) => {
    console.warn("Unable to play transport sound:", error)
  })
}

function playAnnouncement() {
  playAudio(announcementAudio)
}

function playCancellation() {
  playAudio(cancelledAudio)
}

document.addEventListener("turbo:load", () => {
  initializeAudio()
  updateSoundButton()

  const button = document.getElementById("enable-bell")

  if (!button) return

  button.addEventListener("click", toggleSound)
})

document.addEventListener("turbo:before-stream-render", (event) => {
  const stream = event.target

  if (
    stream.getAttribute("target") === "transporter-requests"
  ) {
    const sound = stream.getAttribute("data-sound")

    if (sound === "announcement") {
      playAnnouncement()
    } else if (sound === "cancelled") {
      playCancellation()
    }
  }
})

document.addEventListener("turbo:before-stream-render", (event) => {
  const stream = event.target

  if (
    stream.getAttribute("action") === "update" &&
    stream.getAttribute("target") === "viewer-refresh"
  ) {
    window.location.reload()
  }
})