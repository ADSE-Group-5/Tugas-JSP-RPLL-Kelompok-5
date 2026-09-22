<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Soal 3 — Persamaan Kuadrat</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
    <style>
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --bg-deep: #0a0a1a;
            --glass-bg: rgba(255, 255, 255, 0.04);
            --glass-border: rgba(255, 255, 255, 0.08);
            --accent-blue: #4f8eff;
            --accent-purple: #a855f7;
            --accent-cyan: #22d3ee;
            --text-primary: rgba(255, 255, 255, 0.92);
            --text-secondary: rgba(255, 255, 255, 0.55);
            --text-muted: rgba(255, 255, 255, 0.35);
            --shadow-float: 0 20px 60px rgba(0, 0, 0, 0.4), 0 0 40px rgba(168, 85, 247, 0.06);
            --radius: 20px;
            --blur: 16px;
            --input-bg: rgba(255, 255, 255, 0.05);
            --input-border: rgba(255, 255, 255, 0.1);
            --input-focus: rgba(168, 85, 247, 0.3);
        }

        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--bg-deep);
            color: var(--text-primary);
            min-height: 100vh;
            overflow-x: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            perspective: 1200px;
        }

        .spatial-bg { position: fixed; inset: 0; z-index: 0; overflow: hidden; }
        .orb { position: absolute; border-radius: 50%; filter: blur(80px); will-change: transform; }
        .orb-1 { width: 450px; height: 450px; background: radial-gradient(circle, var(--accent-purple), transparent 70%); top: -15%; right: -10%; opacity: 0.3; }
        .orb-2 { width: 350px; height: 350px; background: radial-gradient(circle, var(--accent-blue), transparent 70%); bottom: -10%; left: -5%; opacity: 0.25; }

        .grid-overlay {
            position: fixed; inset: 0; z-index: 1;
            background-image:
                linear-gradient(rgba(255,255,255,0.015) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,0.015) 1px, transparent 1px);
            background-size: 60px 60px;
            transform: perspective(800px) rotateX(60deg);
            transform-origin: center top;
            opacity: 0.5;
            mask-image: linear-gradient(to bottom, transparent, black 30%, black 70%, transparent);
        }

        .form-scene {
            position: relative;
            z-index: 10;
            width: 100%;
            max-width: 480px;
            padding: 20px;
        }

        .back-link {
            display: inline-flex; align-items: center; gap: 8px;
            color: var(--text-secondary); text-decoration: none; font-size: 14px;
            margin-bottom: 28px; opacity: 0; transform: translateX(-20px);
            transition: color 0.3s ease-out;
        }
        .back-link:hover { color: var(--text-primary); }

        .page-header {
            text-align: center; margin-bottom: 36px;
            opacity: 0; transform: translateY(30px);
        }
        .page-header .icon {
            font-size: 40px; display: block; margin-bottom: 12px;
            filter: drop-shadow(0 0 16px rgba(168, 85, 247, 0.4));
        }
        .page-header h1 {
            font-size: 26px; font-weight: 700;
            background: linear-gradient(135deg, #fff, var(--accent-purple));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
        }
        .page-header p {
            margin-top: 8px; font-size: 13px;
            color: var(--text-muted); letter-spacing: 1.5px; text-transform: uppercase;
        }

        /* EQUATION DISPLAY */
        .equation-display {
            text-align: center;
            margin-bottom: 28px;
            opacity: 0;
            transform: translateY(20px);
        }
        .equation-display .eq {
            display: inline-block;
            font-size: 22px;
            font-weight: 700;
            font-family: 'Consolas', 'Courier New', monospace;
            padding: 14px 28px;
            background: rgba(168, 85, 247, 0.08);
            border: 1px solid rgba(168, 85, 247, 0.15);
            border-radius: 14px;
            backdrop-filter: blur(8px);
            color: var(--accent-purple);
            letter-spacing: 1px;
        }

        .glass-form {
            position: relative;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius);
            padding: 36px 32px;
            backdrop-filter: blur(var(--blur));
            -webkit-backdrop-filter: blur(var(--blur));
            box-shadow: var(--shadow-float);
            opacity: 0;
            transform: translateY(50px) rotateX(6deg);
            will-change: transform;
        }
        .glass-form::before {
            content: ''; position: absolute; inset: 0;
            border-radius: var(--radius);
            background: linear-gradient(135deg, rgba(255,255,255,0.05) 0%, transparent 50%);
            pointer-events: none;
        }

        /* 3-COLUMN INPUT ROW */
        .input-row {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 14px;
            margin-bottom: 24px;
        }

        .input-group { }
        .input-group label {
            display: block; font-size: 13px; font-weight: 600;
            color: var(--text-secondary); margin-bottom: 8px;
            letter-spacing: 0.5px; text-transform: uppercase;
            text-align: center;
        }
        .input-group input {
            width: 100%; padding: 14px 12px;
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: 12px;
            color: var(--text-primary);
            font-size: 18px;
            font-family: 'Consolas', monospace;
            text-align: center;
            outline: none;
            transition: border-color 0.3s ease-out, box-shadow 0.3s ease-out, background 0.3s ease-out;
        }
        .input-group input::placeholder { color: var(--text-muted); font-size: 14px; }
        .input-group input:focus {
            border-color: var(--accent-purple);
            box-shadow: 0 0 0 3px var(--input-focus);
            background: rgba(255, 255, 255, 0.07);
        }

        .input-group .input-hint {
            display: block;
            text-align: center;
            font-size: 11px;
            color: var(--text-muted);
            margin-top: 6px;
        }

        .submit-btn {
            width: 100%; padding: 16px; margin-top: 4px;
            border: none; border-radius: 14px;
            font-size: 16px; font-weight: 600; font-family: inherit;
            color: #fff; cursor: pointer;
            position: relative; overflow: hidden;
            background: linear-gradient(135deg, var(--accent-purple), var(--accent-blue));
            box-shadow: 0 8px 30px rgba(168, 85, 247, 0.25);
            transition: transform 0.3s ease-out, box-shadow 0.3s ease-out;
            will-change: transform;
        }
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 40px rgba(168, 85, 247, 0.35);
        }
        .submit-btn:active { transform: translateY(0) scale(0.98); }
        .submit-btn::after {
            content: ''; position: absolute;
            top: -50%; left: -50%; width: 200%; height: 200%;
            background: linear-gradient(to right, transparent 0%, rgba(255,255,255,0.1) 50%, transparent 100%);
            transform: rotate(30deg) translateX(-100%);
            transition: transform 0.6s ease-out;
        }
        .submit-btn:hover::after { transform: rotate(30deg) translateX(100%); }

        .formula-hint {
            margin-top: 20px; padding: 14px 16px;
            background: rgba(168, 85, 247, 0.06);
            border: 1px solid rgba(168, 85, 247, 0.1);
            border-radius: 12px;
            font-size: 13px; color: var(--text-secondary); line-height: 1.8;
        }
        .formula-hint code {
            color: var(--accent-cyan);
            font-family: 'Consolas', monospace;
            background: rgba(34, 211, 238, 0.08);
            padding: 2px 6px; border-radius: 4px;
        }

        .particle {
            position: fixed; width: 3px; height: 3px;
            background: rgba(255,255,255,0.12); border-radius: 50%;
            pointer-events: none; z-index: 2;
        }

        @media (prefers-reduced-motion: reduce) {
            .glass-form, .page-header, .back-link, .equation-display {
                opacity: 1 !important; transform: none !important; transition: none !important;
            }
            .submit-btn::after { display: none; }
            .orb, .particle { display: none; }
            .grid-overlay { transform: none; }
        }
    </style>
</head>
<body>

    <div class="spatial-bg">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
    </div>
    <div class="grid-overlay"></div>

    <div class="form-scene">
        <a href="index.jsp" class="back-link">← Kembali ke Menu</a>

        <div class="page-header">
            <span class="icon">📊</span>
            <h1>Persamaan Kuadrat</h1>
            <p>Soal 3 • Rumus ABC • Diskriminan</p>
        </div>

        <div class="equation-display">
            <span class="eq">ax² + bx + c = 0</span>
        </div>

        <div class="glass-form">
            <form action="HitungPersamaanKuadrat" method="post">
                <div class="input-row">
                    <div class="input-group">
                        <label for="a">Nilai a</label>
                        <input type="number" id="a" name="a" step="any" required placeholder="a">
                        <span class="input-hint">a ≠ 0</span>
                    </div>
                    <div class="input-group">
                        <label for="b">Nilai b</label>
                        <input type="number" id="b" name="b" step="any" required placeholder="b">
                        <span class="input-hint">&nbsp;</span>
                    </div>
                    <div class="input-group">
                        <label for="c">Nilai c</label>
                        <input type="number" id="c" name="c" step="any" required placeholder="c">
                        <span class="input-hint">&nbsp;</span>
                    </div>
                </div>

                <button type="submit" class="submit-btn">Selesaikan Persamaan →</button>
            </form>

            <div class="formula-hint">
                <code>D = b² - 4ac</code><br>
                <code>x = (-b ± √D) / 2a</code><br>
                D &gt; 0 → Akar real berbeda &nbsp;|&nbsp;
                D = 0 → Akar kembar &nbsp;|&nbsp;
                D &lt; 0 → Akar imajiner
            </div>
        </div>
    </div>

    <script>
        const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
        if (!prefersReducedMotion) {
            gsap.to('.back-link', { opacity: 1, x: 0, duration: 0.8, ease: 'power3.out', delay: 0.1 });
            gsap.to('.page-header', { opacity: 1, y: 0, duration: 1, ease: 'power3.out', delay: 0.2 });
            gsap.to('.equation-display', { opacity: 1, y: 0, duration: 0.8, ease: 'back.out(1.7)', delay: 0.4 });
            gsap.to('.glass-form', { opacity: 1, y: 0, rotateX: 0, duration: 1, ease: 'power3.out', delay: 0.5 });

            gsap.to('.orb-1', { x: -25, y: 20, duration: 9, ease: 'sine.inOut', yoyo: true, repeat: -1 });
            gsap.to('.orb-2', { x: 20, y: -15, duration: 11, ease: 'sine.inOut', yoyo: true, repeat: -1 });

            const form = document.querySelector('.glass-form');
            form.addEventListener('mousemove', e => {
                const rect = form.getBoundingClientRect();
                const rotateX = ((e.clientY - rect.top) - rect.height / 2) / 30;
                const rotateY = (rect.width / 2 - (e.clientX - rect.left)) / 30;
                gsap.to(form, { rotateX, rotateY, duration: 0.4, ease: 'power2.out', transformPerspective: 800 });
            });
            form.addEventListener('mouseleave', () => {
                gsap.to(form, { rotateX: 0, rotateY: 0, duration: 0.6, ease: 'power2.out' });
            });

            for (let i = 0; i < 15; i++) {
                const p = document.createElement('div');
                p.classList.add('particle');
                p.style.left = Math.random() * 100 + 'vw';
                p.style.top = Math.random() * 100 + 'vh';
                document.body.appendChild(p);
                gsap.to(p, { y: -80 - Math.random() * 100, opacity: 0, duration: 4 + Math.random() * 5, ease: 'none', repeat: -1, delay: Math.random() * 4 });
            }
        }
    </script>
</body>
</html>
