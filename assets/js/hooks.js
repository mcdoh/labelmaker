const Hooks = {};

Hooks.EnterToNewline = {
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
};

export default Hooks;
