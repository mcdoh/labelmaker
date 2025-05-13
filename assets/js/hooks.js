const Hooks = {
	EnterToNewline: {
		mounted() {
			this.el.addEventListener('keydown', (e) => {
				if (e.key === 'Enter' && !e.shiftKey) {
					e.preventDefault();

					const cursorPos = this.el.selectionStart;
					const value = this.el.value;

					this.el.value = value.slice(0, cursorPos) + '\\n' + value.slice(cursorPos);
					this.el.selectionStart = this.el.selectionEnd = cursorPos + 2;
				}
			});
		},
	},

	PersistData: {
		mounted() {
			const form = this.el;
			const key = 'label';
			const stored = JSON.parse(localStorage.getItem(key) || '{}');

			let updated = false;

			for (let [name, value] of Object.entries(stored)) {
				const input = form.querySelector(`[name="${name}"]`);

				if (input) {
					input.value = value;
					updated = true;
				}
			}

			if (updated) {
				this.pushEvent('update_label', stored);
			}

			form.addEventListener('input', () => {
				const data = {};

				for (let el of form.elements) {
					if (el.name) data[el.name] = el.value;
				}

				localStorage.setItem(key, JSON.stringify(data));
			});
		},
	},
};

export default Hooks;
