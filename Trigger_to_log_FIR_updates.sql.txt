CREATE TABLE fir_logs (
    log_id SERIAL PRIMARY KEY,
    fir_id INT,
    action VARCHAR(50),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_fir_update()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO fir_logs (fir_id, action)
    VALUES (NEW.fir_id, 'FIR Updated');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_fir_update
AFTER UPDATE ON firs
FOR EACH ROW EXECUTE FUNCTION log_fir_update();
