#pragma once


class Player
{
public:
	Player(int posX, int posY) :
		m_positionX(posX),
		m_positionY(posY),
		m_numBombs(3) {}

	inline void move(int& x, int& y) {
		if (m_positionX + x > 19 || m_positionY + y > 19) {
			return;
		}

		m_positionX += x;
		m_positionY += y;
	}

	inline void useBomb() {
		m_numBombs--;
	}

	inline int GetXPosition() const { return m_positionX; }
	inline int GetYPosition() const { return m_positionY; }
	inline int GetNumBombs() const { return m_numBombs; }

	inline void SetXPosition(int& newX) { m_positionX = newX; }
	inline void SetYPosition(int& newY) { m_positionY = newY; }
	inline void SetNumBombs(int& val) { m_numBombs = val; }

private:
	int m_positionX;
	int m_positionY;
	int m_numBombs;
};

