<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tugas JSP & Servlet</title>

    <!-- GSAP for buttery-smooth animations -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>

    <style>
        /* ========================================
           ANTIGRAVITY DESIGN SYSTEM — ROOT
           ======================================== */
        *, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

        :root {
            --bg-deep: #0a0a1a;
            --bg-mid: #12122a;
            --glass-bg: rgba(255, 255, 255, 0.04);
            --glass-border: rgba(255, 255, 255, 0.08);
            --glass-highlight: rgba(255, 255, 255, 0.12);
            --accent-blue: #4f8eff;
            --accent-purple: #a855f7;
            --accent-cyan: #22d3ee;
            --text-primary: rgba(255, 255, 255, 0.92);
            --text-secondary: rgba(255, 255, 255, 0.55);
            --shadow-float: 0 20px 60px rgba(0, 0, 0, 0.4), 0 0 40px rgba(79, 142, 255, 0.06);
            --shadow-hover: 0 30px 80px rgba(0, 0, 0, 0.5), 0 0 60px rgba(79, 142, 255, 0.1);
            --radius: 20px;
            --blur: 16px;
        }

        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--bg-deep);
            color: var(--text-primary);
            min-height: 100vh;
            overflow-x: hidden;
            perspective: 1200px;
        }

        /* ========================================
           SPATIAL BACKGROUND — DEPTH LAYERS
           ======================================== */
        .spatial-bg {
            position: fixed;
            inset: 0;
            z-index: 0;
            overflow: hidden;
        }

        .spatial-bg .orb {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.3;
            will-change: transform;
        }

        .orb-1 {
            width: 500px; height: 500px;
            background: radial-gradient(circle, var(--accent-blue), transparent 70%);
            top: -10%; left: -5%;
        }
        .orb-2 {
            width: 400px; height: 400px;
            background: radial-gradient(circle, var(--accent-purple), transparent 70%);
            bottom: -15%; right: -10%;
        }
        .orb-3 {
            width: 300px; height: 300px;
            background: radial-gradient(circle, var(--accent-cyan), transparent 70%);
            top: 40%; right: 20%;
            opacity: 0.15;
        }

        /* Grid overlay for spatial depth */
        .grid-overlay {
            position: fixed;
            inset: 0;
            z-index: 1;
            background-image:
                linear-gradient(rgba(255,255,255,0.02) 1px, transparent 1px),
                linear-gradient(90deg, rgba(255,255,255,0.02) 1px, transparent 1px);
            background-size: 60px 60px;
            transform: perspective(800px) rotateX(60deg);
            transform-origin: center top;
            opacity: 0.4;
            mask-image: linear-gradient(to bottom, transparent, black 30%, black 70%, transparent);
        }

        /* ========================================
           MAIN CONTENT
           ======================================== */
        .main-container {
            position: relative;
            z-index: 10;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 60px 20px;
        }

        /* ========================================
           HEADER — FLOATING TITLE
           ======================================== */
        .hero-title {
            text-align: center;
            margin-bottom: 60px;
            opacity: 0;
            transform: translateY(40px);
        }

        .hero-title .icon {
            font-size: 48px;
            display: block;
            margin-bottom: 16px;
            filter: drop-shadow(0 0 20px rgba(79, 142, 255, 0.4));
        }

        .hero-title h1 {
            font-size: clamp(28px, 5vw, 42px);
            font-weight: 700;
            letter-spacing: -0.5px;
            background: linear-gradient(135deg, #fff 0%, var(--accent-blue) 50%, var(--accent-purple) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero-title p {
            margin-top: 12px;
            font-size: 16px;
            color: var(--text-secondary);
            letter-spacing: 2px;
            text-transform: uppercase;
            font-weight: 300;
        }

        /* ========================================
           GLASS CARDS — WEIGHTLESS & FLOATING
           ======================================== */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 30px;
            max-width: 900px;
            width: 100%;
        }

        .glass-card {
            position: relative;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius);
            padding: 36px 32px;
            backdrop-filter: blur(var(--blur));
            -webkit-backdrop-filter: blur(var(--blur));
            box-shadow: var(--shadow-float);
            cursor: pointer;
            text-decoration: none;
            color: var(--text-primary);
            overflow: hidden;
            will-change: transform, box-shadow;
            transition: box-shadow 0.4s ease-out;
            /* Initial state for GSAP */
            opacity: 0;
            transform: translateY(60px) rotateX(8deg);
        }

        .glass-card::before {
            content: '';
            position: absolute;
            inset: 0;
            border-radius: var(--radius);
            background: linear-gradient(135deg, rgba(255,255,255,0.06) 0%, transparent 50%);
            pointer-events: none;
        }

        /* Hover glow ring */
        .glass-card::after {
            content: '';
            position: absolute;
            inset: -1px;
            border-radius: var(--radius);
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-purple));
            z-index: -1;
            opacity: 0;
            transition: opacity 0.4s ease-out;
        }

        .glass-card:hover::after {
            opacity: 0.3;
        }

        .glass-card:hover {
            box-shadow: var(--shadow-hover);
        }

        .card-number {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            margin-bottom: 20px;
            letter-spacing: 0.5px;
        }

        .card-number.blue {
            background: rgba(79, 142, 255, 0.15);
            color: var(--accent-blue);
            border: 1px solid rgba(79, 142, 255, 0.2);
        }

        .card-number.purple {
            background: rgba(168, 85, 247, 0.15);
            color: var(--accent-purple);
            border: 1px solid rgba(168, 85, 247, 0.2);
        }

        .glass-card h2 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
            letter-spacing: -0.3px;
        }

        .glass-card p {
            font-size: 14px;
            color: var(--text-secondary);
            line-height: 1.6;
        }

        .card-arrow {
            position: absolute;
            bottom: 28px;
            right: 28px;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: var(--glass-highlight);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            transition: transform 0.3s ease-out, background 0.3s ease-out;
        }

        .glass-card:hover .card-arrow {
            transform: translateX(4px);
            background: rgba(79, 142, 255, 0.2);
        }

        /* ========================================
           FLOATING PARTICLES
           ======================================== */
        .particle {
            position: fixed;
            width: 4px;
            height: 4px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 50%;
            pointer-events: none;
            z-index: 2;
        }

        /* ========================================
           REDUCED MOTION — ACCESSIBILITY
           ======================================== */
        @media (prefers-reduced-motion: reduce) {
            .glass-card,
            .hero-title {
                opacity: 1 !important;
                transform: none !important;
                transition: none !important;
            }
            .orb, .particle { display: none; }
            .grid-overlay { transform: none; }
        }
    </style>
</head>
<body>

    <!-- SPATIAL BACKGROUND -->
    <div class="spatial-bg">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
        <div class="orb orb-3"></div>
    </div>
    <div class="grid-overlay"></div>

    <!-- FLOATING PARTICLES (generated by JS) -->

    <!-- MAIN CONTENT -->
    <div class="main-container">

        <div class="hero-title">
            <span class="icon">📐</span>
            <h1>Tugas JSP & Servlet</h1>
            <p>Java Server Pages • Servlet Architecture</p>
        </div>

        <div class="card-grid">

            <a href="persegipanjang.jsp" class="glass-card" data-card="0">
                <span class="card-number blue">1&2</span>
                <h2>Persegi Panjang & Bujur Sangkar</h2>
                <p>Menghitung luas & keliling persegi panjang, dengan deteksi otomatis bentuk bujur sangkar.</p>
                <div class="card-arrow">→</div>
            </a>

            <a href="persamaankuadrat.jsp" class="glass-card" data-card="1">
                <span class="card-number purple">3</span>
                <h2>Persamaan Kuadrat</h2>
                <p>Menyelesaikan persamaan ax² + bx + c = 0 dengan rumus ABC dan analisis diskriminan.</p>
                <div class="card-arrow">→</div>
            </a>

        </div>
    </div>

    <script>
        // ========================================
        // GSAP — ANTIGRAVITY ENTRANCE ANIMATIONS
        // ========================================

        // Check for reduced motion preference
        const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

        if (!prefersReducedMotion) {

            // Hero title float in
            gsap.to('.hero-title', {
                opacity: 1,
                y: 0,
                duration: 1.2,
                ease: 'power3.out',
                delay: 0.2
            });

            // Cards — staggered entrance (domino drop-in)
            gsap.to('.glass-card', {
                opacity: 1,
                y: 0,
                rotateX: 0,
                duration: 0.9,
                ease: 'power3.out',
                stagger: 0.15,
                delay: 0.6
            });

            // Background orbs — slow breathing motion
            gsap.to('.orb-1', {
                x: 30, y: 20,
                duration: 8,
                ease: 'sine.inOut',
                yoyo: true,
                repeat: -1
            });
            gsap.to('.orb-2', {
                x: -25, y: -15,
                duration: 10,
                ease: 'sine.inOut',
                yoyo: true,
                repeat: -1
            });
            gsap.to('.orb-3', {
                x: 20, y: 25,
                duration: 12,
                ease: 'sine.inOut',
                yoyo: true,
                repeat: -1
            });

            // Card hover — 3D tilt effect
            document.querySelectorAll('.glass-card').forEach(card => {
                card.addEventListener('mousemove', e => {
                    const rect = card.getBoundingClientRect();
                    const x = e.clientX - rect.left;
                    const y = e.clientY - rect.top;
                    const centerX = rect.width / 2;
                    const centerY = rect.height / 2;
                    const rotateX = (y - centerY) / 20;
                    const rotateY = (centerX - x) / 20;

                    gsap.to(card, {
                        rotateX: rotateX,
                        rotateY: rotateY,
                        duration: 0.4,
                        ease: 'power2.out',
                        transformPerspective: 800
                    });
                });

                card.addEventListener('mouseleave', () => {
                    gsap.to(card, {
                        rotateX: 0,
                        rotateY: 0,
                        duration: 0.6,
                        ease: 'power2.out'
                    });
                });
            });

            // Floating particles
            for (let i = 0; i < 20; i++) {
                const p = document.createElement('div');
                p.classList.add('particle');
                p.style.left = Math.random() * 100 + 'vw';
                p.style.top = Math.random() * 100 + 'vh';
                p.style.width = p.style.height = (Math.random() * 3 + 2) + 'px';
                document.body.appendChild(p);

                gsap.to(p, {
                    y: -80 - Math.random() * 120,
                    x: (Math.random() - 0.5) * 60,
                    opacity: 0,
                    duration: 4 + Math.random() * 6,
                    ease: 'none',
                    repeat: -1,
                    delay: Math.random() * 5
                });
            }
        }
    </script>
</body>
</html>
